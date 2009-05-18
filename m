From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: [PATCH  2/3] hid: Multitouch support for the N-Trig touchscreen
Date: Tue, 19 May 2009 00:10:43 +0200
Message-ID: <2DB714C8-82E9-411A-881D-5327C521B5FC@enac.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:51459 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506AbZERWj5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 May 2009 18:39:57 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suze.cz, Henrik Rydberg <rydberg@euromail.se>
Cc: Mohamed Ikbel Boulabiar <medikbel@lii-enac.fr>, Sebastien Hamdani <sebastien.hamdani@gmail.com>

Exported hidinput_hid_event, so as to be able to call it from device- 
specific drivers.

Signed-off-by: Stephane Chatty <chatty@enac.fr>

diff -rupN a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
--- a/drivers/hid/hid-input.c	2009-05-09 02:14:14.000000000 +0200
+++ b/drivers/hid/hid-input.c	2009-05-16 16:10:39.000000000 +0200
@@ -653,6 +653,7 @@ void hidinput_hid_event(struct hid_devic
  	if ((field->flags & HID_MAIN_ITEM_RELATIVE) && (usage->type ==  
EV_KEY))
  		input_event(input, usage->type, usage->code, 0);
  }
+EXPORT_SYMBOL_GPL(hidinput_hid_event);

  void hidinput_report_event(struct hid_device *hid, struct  
hid_report *report)
  {

