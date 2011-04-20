From: Khachik Shahzadyan <qwerity@gmail.com>
Subject: Linux Input Devices
Date: Wed, 20 Apr 2011 11:05:57 +0500
Message-ID: <BANLkTinBKXArNg0O7voFdQ-AZ0hYpLUBhw@mail.gmail.com>
References: <BANLkTin0cpZdEZ9=C90jcjppmBn43jBrpg@mail.gmail.com>
 <BANLkTi=xvTL2k6BmxNta5=UoeJOrwajapA@mail.gmail.com> <20110419223057.GA3235@lovely.krouter>
 <BANLkTim7GmpS9ZqxMAQXk99i40R_Qcj=rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55591 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab1DTGGS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Apr 2011 02:06:18 -0400
Received: by ewy4 with SMTP id 4so108788ewy.19
        for <linux-input@vger.kernel.org>; Tue, 19 Apr 2011 23:06:17 -0700 (PDT)
In-Reply-To: <BANLkTim7GmpS9ZqxMAQXk99i40R_Qcj=rg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello!
I found your email in a kernel sources and i think that i can seek help=
 to you)
I try to write a virtual joystick driver for my project, how can i do i=
t?
Can i create only a char device (/dev/input/js0)

with fops: {ioctl, write, read, open}

or i need to create something like joydev.c ?
p.s. i have one application that must write moves to /dev/input/js0
and other applications can read this events from it, and they does not
understand that it's a virtual joystick!

--=20
with best regards=C2=A0Khachik=C2=A0Shahzadyan
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
