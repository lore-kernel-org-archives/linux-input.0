From: Andreas Nielsen <eas@svep.se>
Subject: RE: [PATCH] HID: multitouch: add PID for Fructel product
Date: Tue, 20 Mar 2012 13:12:27 +0100
Message-ID: <884EB0E38721BD4797EDF5AE1D66333C03F4953A95BE@Exchange-1.svep.se>
References: <1332168063-24812-1-git-send-email-eas@svep.se>
 <CAPHpN5Nn1JQtOQML8Y=2iL8Qy5SFjxMbf1uggNDVqoeeeegWCg@mail.gmail.com>
 <884EB0E38721BD4797EDF5AE1D66333C03F4953A9533@Exchange-1.svep.se>
 <alpine.LNX.2.00.1203201225080.18356@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exchange.svep.se ([213.80.127.210]:13634 "EHLO
	Exchange-1.svep.se" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759864Ab2CTMNF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Mar 2012 08:13:05 -0400
In-Reply-To: <alpine.LNX.2.00.1203201225080.18356@pobox.suse.cz>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "benjamin.tissoires@enac.fr" <benjamin.tissoires@enac.fr>, "chatty@enac.fr" <chatty@enac.fr>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

Hi Jiri,

sounds good to me.

Thanks
/Andreas

-----Original Message-----
From: Jiri Kosina [mailto:jkosina@suse.cz] 
Sent: den 20 mars 2012 12:26
To: Andreas Nielsen
Cc: Mohamed Ikbel Boulabiar; linux-input@vger.kernel.org; benjamin.tissoires@enac.fr; chatty@enac.fr; dmitry.torokhov@gmail.com
Subject: RE: [PATCH] HID: multitouch: add PID for Fructel product

On Mon, 19 Mar 2012, Andreas Nielsen wrote:

> The multitouch events are emulated by the Gametel device. Each 
> physical button is configured to generate a MT event on a specific coordinate.
> This seems to be the only way for us to support Android games that 
> doesn't support HID gamepads. It is possible to inject MT events at 
> Android level, but this requires the user to root their phone which 
> isn't realistic for our users.

Andreas,

I will be updating the Changelog message with this bit of explanation before comitting the patch, ok?

--
Jiri Kosina
SUSE Labs
