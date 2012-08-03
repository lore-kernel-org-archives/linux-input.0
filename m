From: Yann Cantin <yann.cantin@laposte.net>
Subject: Re: [RFC ebeam PATCH v2 0/3] new USB eBeam input driver
Date: Fri, 03 Aug 2012 14:13:23 +0200
Message-ID: <501BC063.9040502@laposte.net>
References: <1343912397-18353-1-git-send-email-yann.cantin@laposte.net> <alpine.LRH.2.00.1208021602250.15211@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:49612 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504Ab2HCMM5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Aug 2012 08:12:57 -0400
In-Reply-To: <alpine.LRH.2.00.1208021602250.15211@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org

Hi,

Le 02/08/2012 16:16, Jiri Kosina a =E9crit :
>> Patch 1 and 2 are here to let the ebeam driver be choose to handle
>> the device instead of the generic-usb hid one (totally useless).
>=20
> Just merge 1 and 2 together, not necessary to have two commits becaus=
e of=20
> that.

Ok, will do that for the next iteration of the patchset (i don't think
i need to resubmit now with this change only, no?)

Thanks.
--=20
Yann Cantin
A4FEB47F
--
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
