From: "Arce, Abraham" <x0066660@ti.com>
Subject: EV_MSC/MSC_SCAN Behaviour
Date: Wed, 12 May 2010 14:53:48 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E08FE1A@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52381 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757499Ab0ELTxu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 May 2010 15:53:50 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4CJrotc025662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-input@vger.kernel.org>; Wed, 12 May 2010 14:53:50 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id o4CJrnIL014814
	for <linux-input@vger.kernel.org>; Wed, 12 May 2010 14:53:49 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o4CJrn0f013436
	for <linux-input@vger.kernel.org>; Wed, 12 May 2010 14:53:49 -0500 (CDT)
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi,

I have searched for documentation regarding this type of event but still not clear about the behaviour.

input_set_capability(input_dev, EV_MSC, MSC_SCAN);
input_event(input_dev, EV_MSC, MSC_SCAN, code);

Without enabling it I am able to get events properly reported using evtest in key press, release and kept depressed

  Event: time 946684817.945892, type 1 (Key), code 18 (E), value 2

If I enable it then, If I press and release a key no code will be reported

  Event: time 946684836.854248, -------------- Report Sync ------------
  Event: time 946684836.854248, -------------- Report Sync ------------

Unless I keep it depressed

  Event: time 946684817.945892, type 1 (Key), code 18 (E), value 2

And after releasing the key some other events will get generated

  Event: time 946684817.967559, type 4 (Misc), code 4 (ScanCode), value 24
  Event: time 946684817.967559, -------------- Report Sync ------------
  Event: time 946684817.967559, type 4 (Misc), code 4 (ScanCode), value 32
  Event: time 946684817.967559, -------------- Report Sync ------------
  Event: time 946684817.967590, type 4 (Misc), code 4 (ScanCode), value 40
  Event: time 946684817.967590, -------------- Report Sync ------------

Am I missing something?

Best Regards
Abraham
