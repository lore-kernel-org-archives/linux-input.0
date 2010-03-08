From: Benjamin Tissoires <tissoire@cena.fr>
Subject: [PATCH 0/3] hid-magicmouse: delete the second input device
Date: Mon, 08 Mar 2010 22:29:28 +0100
Message-ID: <1268083768.9018.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:44558 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755523Ab0CHV3i (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Mar 2010 16:29:38 -0500
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 18D8CD48118
	for <linux-input@vger.kernel.org>; Mon,  8 Mar 2010 22:29:32 +0100 (CET)
Received: from [192.168.0.112] (lan31-8-82-247-176-67.fbx.proxad.net [82.247.176.67])
	by smtp5-g21.free.fr (Postfix) with ESMTP id CFACED4818A
	for <linux-input@vger.kernel.org>; Mon,  8 Mar 2010 22:29:29 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

in the current implementation of hid-magicmouse, the driver creates two
input device. As the Magic Mouse does not reports at the connexion the
fields of the multitouch part, the previous implementation creates a
second device to report to the user space the other axes.

I manage to remove this second device by manually injecting the fields
in the report created by the hid_register_report.

To do that, I had to export the function hid_register_field. This is the
object of the first patch.
Then, in the second patch, I inject the fields in the report, thus
removing the line containing 'report->size = 6;'
The last patch is just a cleanup.

Cheers,
Benjamin

