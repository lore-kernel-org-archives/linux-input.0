From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: Disable i8042 check on Apple machines
Date: Tue, 17 Dec 2013 10:25:36 -0500
Message-ID: <CA+5PVA565FmR+f5eOZDSUv_pb-pbgExg5L6zHXf9aJyNUoRVdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:58644 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325Ab3LQPZh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Dec 2013 10:25:37 -0500
Received: by mail-ob0-f176.google.com with SMTP id vb8so6437760obc.21
        for <linux-input@vger.kernel.org>; Tue, 17 Dec 2013 07:25:36 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <bnocera@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Bastien and Dmitry,

I was going through some of the patches we're carrying in Fedora and
came across this one that Bastien submitted a long time ago:

http://lkml.indiana.edu/hypermail/linux/kernel/1005.0/00938.html

It works and we're still carrying it, but Dmitry said it needed to be
done differently in i8042-x86ia64io.h.  Would that just mean adding a
DMI for Apple machines to the i8042_dmi_nopnp_table struct?  Or
exactly what should be done here?

I'd like to get this upstream.

josh
