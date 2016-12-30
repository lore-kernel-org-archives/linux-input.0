From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [RFC] input: Add disable sysfs entry for every input device
Date: Fri, 30 Dec 2016 19:13:47 +0300
Message-ID: <bdd60670-5961-f119-52ff-3d10b7f6fb91@cogentembedded.com>
References: <1482660296-8432-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36365 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753959AbcL3QNv (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 30 Dec 2016 11:13:51 -0500
Received: by mail-lf0-f42.google.com with SMTP id t196so239415293lff.3
        for <linux-input@vger.kernel.org>; Fri, 30 Dec 2016 08:13:50 -0800 (PST)
In-Reply-To: <1482660296-8432-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Chuck Ebbert <cebbert.lkml@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>

Hi

>  	&dev_attr_properties.attr,
> +	&dev_arrr_disable.attr,

Typo here.

After fixing that,

Tested-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

