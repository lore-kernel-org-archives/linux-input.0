From: william@attente.ca
Subject: Re: [PATCH] HID: rmi: Make sure the HID device is opened on
 resume
Date: Tue, 08 Aug 2017 14:45:37 +0000
Message-ID: <a4c2e87fea4a701fd2a8b13110861a9f@_>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out.migadu.com ([188.165.195.186]:43394 "EHLO smtp.migadu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752030AbdHHOxK (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 8 Aug 2017 10:53:10 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

> So, call hid_hw_open() in rmi_post_resume() so we make sure that the de=
vice is alive before we try=0A> talking to it.=0A> =0A> This fixes RMI de=
vice suspend/resume over HID.=0A=0ATested-by: William Hua <william@attent=
e.ca>=0A=0AThank you, I applied this patch to tag v4.13-rc4 and my Dell X=
PS 13 9333 touchpad now works again after suspend.
