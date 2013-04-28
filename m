From: Alessandro Osima <alex.osima@gmail.com>
Subject: Evdev like userspace/kernelspace communication system for char devices
Date: Sun, 28 Apr 2013 16:14:54 +0200
Message-ID: <81377016-9726-4F81-8933-BF496C23DFB7@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177]:45647 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab3D1OPB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Apr 2013 10:15:01 -0400
Received: by mail-ea0-f177.google.com with SMTP id q10so1319274eaj.22
        for <linux-input@vger.kernel.org>; Sun, 28 Apr 2013 07:14:59 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Hunyue Yau <hy-gsoc@hy-research.com>

Hello everyone, a small update on my project.

I have submitted on the gsoc site an application (http://www.google-mel=
ange.com/gsoc/proposal/review/google/gsoc2013/asion/1) proposing to ext=
end evdev to enable it to handle more subsystems than just input (mainl=
y the iio drivers).=20
Greg Kroah-Hartman in two posts has expressed some concerns on the the =
kernel/userspace APIs, the project timeline and the level of integratio=
n and backward compatibility with evdev. I have therefore revised and d=
etailed the main application trough a post in the comments section.=20
You can find a .txt of it here https://dl.dropboxusercontent.com/u/2647=
7885/Nevdev.txt
I would kindly ask for your feedbacks about the project and in particul=
ar your opinions and comments on the prosed technical approach as descr=
ibed in the =93technical details=94 section of the afore-mentioned post=
=2E

Regards,
Alessandro Osima.--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
