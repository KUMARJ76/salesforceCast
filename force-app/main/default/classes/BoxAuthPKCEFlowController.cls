public class BoxAuthPKCEFlowController {
    
     // Constants for client ID and redirect URI
  private static final String REDIRECT_URI = 'https://ddl000006bviduaq-dev-ed--c.develop.vf.force.com/apex/BoxAuthPKCEFlow';
  private static final String CLIENT_ID = 'fn3zgcjv4g83asgf5522dqgke0v33hhf';
    
    
public String createCodeChallenge() {
    // Generate the code verifier and code challenge as shown above
    String codeVerifier = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
    // Convert to Blob and create a code challenge
    Blob codeVerifierBlob = Blob.valueOf(codeVerifier);
    Blob cryptoDigest = Crypto.generateDigest('SHA-256', codeVerifierBlob);
    // Encode the code challenge in base64url
    return EncodingUtil.base64Encode(cryptoDigest).replace('+', '-').replace('/', '_').replace('=', '');
}
  
    
  public PageReference authenticate(){

    String encodedRedirectUri = EncodingUtil.urlEncode(REDIRECT_URI, 'UTF-8');
    String codeChallenge = createCodeChallenge();
    String endpoint = 'https://account.box.com/api/oauth2/authorize?client_id=' + CLIENT_ID + 
                      '&response_type=code&redirect_uri=' + encodedRedirectUri + 
                      '&code_challenge_method=S256&code_challenge=' + codeChallenge;
    return new PageReference(endpoint);                       
    }
}