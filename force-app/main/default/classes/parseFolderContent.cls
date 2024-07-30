public with sharing class parseFolderContent {
    public Integer total_count;	//2
	public cls_entries[] entries;
	public Integer offset;	//0
	public Integer limit_x;	//100
	public cls_order[] order;
	class cls_entries {
		public String type;	//file
		public String id;	//1605533409549
		public cls_file_version file_version;
		public String sequence_id;	//1
		public String etag;	//1
		public String sha1;	//7a193c130052bb0ba8bc5007b5f05aeb0de91913
		public String name;	//Introduction+to+Integration.pdf
	}
	class cls_file_version {
		public String type;	//file_version
		public String id;	//1764873271149
		public String sha1;	//7a193c130052bb0ba8bc5007b5f05aeb0de91913
	}
	class cls_order {
		public String by_x;	//type
		public String direction;	//ASC
	}
}