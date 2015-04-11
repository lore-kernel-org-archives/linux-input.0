From: kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH next] Input: alps_get_pkt_id_ss4_v2() can be static
Date: Sat, 11 Apr 2015 09:21:11 +0800
Message-ID: <20150411012111.GA64853@snb>
References: <201504110955.4uEmNJDX%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33274 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753233AbbDKBVn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Apr 2015 21:21:43 -0400
Content-Disposition: inline
In-Reply-To: <201504110955.4uEmNJDX%fengguang.wu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>
Cc: kbuild-all@01.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 alps.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index ad741c0..3ef93ff 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1093,7 +1093,7 @@ static void alps_process_packet_v7(struct psmouse *psmouse)
 		alps_process_touchpad_packet_v7(psmouse);
 }
 
-unsigned char alps_get_pkt_id_ss4_v2(unsigned char *byte)
+static unsigned char alps_get_pkt_id_ss4_v2(unsigned char *byte)
 {
 	unsigned char pkt_id = SS4_PACKET_ID_IDLE;
 
@@ -2340,7 +2340,7 @@ static int alps_get_otp_values_ss4_v2(struct psmouse *psmouse,
 	return 0;
 }
 
-int alps_update_device_area_ss4_v2(unsigned char otp[][4],
+static int alps_update_device_area_ss4_v2(unsigned char otp[][4],
 				   struct alps_data *priv)
 {
 	int num_x_electrode;
@@ -2365,7 +2365,7 @@ int alps_update_device_area_ss4_v2(unsigned char otp[][4],
 	return 0;
 }
 
-int alps_update_btn_info_ss4_v2(unsigned char otp[][4], struct alps_data *priv)
+static int alps_update_btn_info_ss4_v2(unsigned char otp[][4], struct alps_data *priv)
 {
 
 	unsigned char is_btnless;
