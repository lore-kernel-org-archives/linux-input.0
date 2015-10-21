From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: reject input outside logical range only if null
 state is set
Date: Wed, 21 Oct 2015 13:28:57 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1510211328240.21100@pobox.suse.cz>
References: <01431f646f00a0ce0995e07578b61bae@be13.mail.saunalahti.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46985 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbbJUL26 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Oct 2015 07:28:58 -0400
In-Reply-To: <01431f646f00a0ce0995e07578b61bae@be13.mail.saunalahti.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: rnd@nic.fi
Cc: linux-input@vger.kernel.org

On Tue, 13 Oct 2015, rnd@nic.fi wrote:

> Kernel 3.19.0 one-line fix for an issue in drivers/hid/hid-input.c wh=
ere USB
> HID control null state flag is not checked when rejecting inputs outs=
ide
> logical minimum-maximum range. The check should be made as per USB HI=
D
> specification 1.11, section 6.2.2.5, p.31. I have no resources for la=
rge-scale
> testing, but this fixes problems with the game controller I have (INN=
EX NES
> Controller USB).
>=20
> More details: https://bugzilla.kernel.org/show_bug.cgi?id=3D68621
>=20
>=20
> Signed-Off-by: Valtteri Heikkil=C3=A4 <rnd@nic.fi>
> --- a/drivers/hid/hid-input.c 2015-05-25 09:58:49.743527141 +0800
> +++ b/drivers/hid/hid-input.c 2015-05-25 11:04:13.201191432 +0800
> @@ -1097,6 +1097,7 @@
> * don't specify logical min and max.
> */
> if ((field->flags & HID_MAIN_ITEM_VARIABLE) &&
> + (field->flags & HID_MAIN_ITEM_NULL_STATE) &&
> (field->logical_minimum < field->logical_maximum) &&
> (value < field->logical_minimum ||
> value > field->logical_maximum)) {

Your patch has been corrupted by your mailer badly. Please try to fix i=
t=20
(some hints are in Documentation/email-clients.txt) and resubmit.

Thanks,

--=20
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
