From: Andreas Nielsen <eas@svep.se>
Subject: RE: [PATCH] HID: multitouch: add PID for Fructel product
Date: Mon, 19 Mar 2012 17:03:18 +0100
Message-ID: <884EB0E38721BD4797EDF5AE1D66333C03F4953A9533@Exchange-1.svep.se>
References: <1332168063-24812-1-git-send-email-eas@svep.se>
 <CAPHpN5Nn1JQtOQML8Y=2iL8Qy5SFjxMbf1uggNDVqoeeeegWCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exchange.svep.se ([213.80.127.210]:19471 "EHLO
	Exchange-1.svep.se" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932256Ab2CSQDX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Mar 2012 12:03:23 -0400
In-Reply-To: <CAPHpN5Nn1JQtOQML8Y=2iL8Qy5SFjxMbf1uggNDVqoeeeegWCg@mail.gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "benjamin.tissoires@enac.fr" <benjamin.tissoires@enac.fr>, "chatty@enac.fr" <chatty@enac.fr>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "jkosina@suse.cz" <jkosina@suse.cz>

The multitouch events are emulated by the Gametel device. Each physical button is configured to generate a MT event on a specific coordinate. This seems to be the only way for us to support Android games that doesn't support HID gamepads. It is possible to inject MT events at Android level, but this requires the user to root their phone which isn't realistic for our users. 

/Andreas

-----Original Message-----
From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Mohamed Ikbel Boulabiar
Sent: den 19 mars 2012 16:43
To: Andreas Nielsen
Cc: linux-input@vger.kernel.org; benjamin.tissoires@enac.fr; chatty@enac.fr; dmitry.torokhov@gmail.com; jkosina@suse.cz
Subject: Re: [PATCH] HID: multitouch: add PID for Fructel product

On Mon, Mar 19, 2012 at 3:41 PM, Andreas Nielsen <eas@svep.se> wrote:
> Adds multitouch support for the Gametel Android game controller
Where's put the mt surface in the controller?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
