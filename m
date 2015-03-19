From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: HID: wacom: check for wacom->shared before following the pointer
Date: Thu, 19 Mar 2015 18:54:25 +0300
Message-ID: <20150319155425.GA727@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:20711 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbbCSPyu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Mar 2015 11:54:50 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org

Hello Benjamin Tissoires,

This is a semi-automatic email about new static checker warnings.

The patch e2c7d8877e5c: "HID: wacom: check for wacom->shared before 
following the pointer" from Mar 5, 2015, leads to the following 
Smatch complaint:

drivers/hid/wacom_wac.c:602 wacom_intuos_inout()
	 error: we previously assumed 'wacom->shared' could be null (see line 584)

drivers/hid/wacom_wac.c
   583	
   584		if (wacom->shared) {

In the original code we checked "if (features->quirks & WACOM_QUIRK_MULTI_INPUT)"
which is ensures that "wacom->shared" is non-NULL.

   585			wacom->shared->stylus_in_proximity = true;
   586	
   587			if (wacom->shared->touch_down)
   588				return 1;
   589		}
   590	
   591		/* in Range while exiting */
   592		if (((data[1] & 0xfe) == 0x20) && wacom->reporting_data) {
   593			input_report_key(input, BTN_TOUCH, 0);
   594			input_report_abs(input, ABS_PRESSURE, 0);
   595			input_report_abs(input, ABS_DISTANCE, wacom->features.distance_max);
   596			return 2;
   597		}
   598	
   599		/* Exit report */
   600		if ((data[1] & 0xfe) == 0x80) {
   601			if (features->quirks & WACOM_QUIRK_MULTI_INPUT)
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
We still check for that here.  Smatch is confused.

   602				wacom->shared->stylus_in_proximity = false;
                                ^^^^^^^^^^^^^
This is not a bug, but change the previous change to
"if (wacom->shared)" would make the code more consistent.

   603			wacom->reporting_data = false;
   604	

[ snip ]

  1072  static int wacom_24hdt_irq(struct wacom_wac *wacom)
  1073  {
  1074          struct input_dev *input = wacom->input;
  1075          unsigned char *data = wacom->data;
  1076          int i;
  1077          int current_num_contacts = data[61];
  1078          int contacts_to_send = 0;
  1079          int num_contacts_left = 4; /* maximum contacts per packet */
  1080          int byte_per_packet = WACOM_BYTES_PER_24HDT_PACKET;
  1081          int y_offset = 2;
  1082          static int contact_with_no_pen_down_count = 0;
  1083  
  1084          if (wacom->features.type == WACOM_27QHDT) {
  1085                  current_num_contacts = data[63];
  1086                  num_contacts_left = 10;
  1087                  byte_per_packet = WACOM_BYTES_PER_QHDTHID_PACKET;
  1088                  y_offset = 0;
  1089          }
  1090  
  1091          /*
  1092           * First packet resets the counter since only the first
  1093           * packet in series will have non-zero current_num_contacts.
  1094           */
  1095          if (current_num_contacts) {
  1096                  wacom->num_contacts_left = current_num_contacts;
  1097                  contact_with_no_pen_down_count = 0;
  1098          }
  1099  
  1100          contacts_to_send = min(num_contacts_left, wacom->num_contacts_left);
  1101  
  1102          for (i = 0; i < contacts_to_send; i++) {
  1103                  int offset = (byte_per_packet * i) + 1;
  1104                  bool touch = (data[offset] & 0x1) && !wacom->shared->stylus_in_proximity;
                                                              ^^^^^^^^^^^^^
I assume this hardware is always quirky so this won't cause a NULL
deref?

  1105                  int slot = input_mt_get_slot_by_key(input, data[offset + 1]);
  1106  
  1107                  if (slot < 0)
  1108                          continue;

regards,
dan carpenter
