From: guo jerry <mimi0213kimo@gmail.com>
Subject: X window don't read my input device automatically
Date: Fri, 19 Jun 2009 10:55:20 +0800
Message-ID: <e715744d0906181955h646e5941y4d54056b1ea4d27e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:37044 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbZFSCzR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Jun 2009 22:55:17 -0400
Received: by wf-out-1314.google.com with SMTP id 26so719655wfd.4
        for <linux-input@vger.kernel.org>; Thu, 18 Jun 2009 19:55:20 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all,
=A0=A0=A0=A0=A0=A0=A0 I have written my multi-touch panel device driver=
 and register
two input devices.
=A0=A0=A0=A0=A0=A0=A0 they appear in /dev/input/event7 & /dev/input/eve=
nt8. The
problem is that why
=A0=A0=A0=A0=A0=A0=A0 X window can read other mouse devices automatical=
ly and work under X
=A0=A0=A0=A0=A0=A0=A0 environment but the device driver written by my o=
wn cannot.
=A0=A0=A0=A0=A0=A0=A0 I guess that if the evbit and keybit which I set =
is not correctly.
=A0=A0=A0=A0=A0=A0=A0 I set my evbit & keybit as following:

=A0=A0=A0=A0=A0=A0=A0 input->evbit[0] =3D BIT_MASK(EV_KEY) || BIT_MASK(=
EV_ABS);
=A0=A0=A0=A0=A0=A0=A0 input->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(B=
TN_TOUCH);

=A0=A0=A0=A0=A0=A0=A0 I'd like solve the problem first then take into i=
ssue=A0 that how to make
=A0=A0=A0=A0=A0=A0=A0 multi-touch work in MPX.

=A0=A0=A0=A0=A0=A0=A0 Thanks in advanced.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
