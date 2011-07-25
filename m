From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 8/9 v2] Input: add BTN_TOOL_QUINTTAP for reporting 5
 fingers on touchpad
Date: Mon, 25 Jul 2011 17:14:22 +0800
Message-ID: <CAGS+omAQmb-q6xC-Gh6z69iNNyr=rN-Khsq90aCHJwe-6F9ANw@mail.gmail.com>
References: <1311169146-20066-1-git-send-email-djkurtz@chromium.org>
 <1311169146-20066-9-git-send-email-djkurtz@chromium.org> <20110725082918.GC22937@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:23355 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832Ab1GYJOo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2011 05:14:44 -0400
Received: from wpaz9.hot.corp.google.com (wpaz9.hot.corp.google.com [172.24.198.73])
	by smtp-out.google.com with ESMTP id p6P9EhY9030502
	for <linux-input@vger.kernel.org>; Mon, 25 Jul 2011 02:14:43 -0700
Received: from iyh42 (iyh42.prod.google.com [10.241.50.234])
	by wpaz9.hot.corp.google.com with ESMTP id p6P9Egok027304
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 25 Jul 2011 02:14:42 -0700
Received: by iyh42 with SMTP id 42so6255868iyh.25
        for <linux-input@vger.kernel.org>; Mon, 25 Jul 2011 02:14:42 -0700 (PDT)
In-Reply-To: <20110725082918.GC22937@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: rydberg@euromail.se, chase.douglas@canonical.com, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

On Mon, Jul 25, 2011 at 4:29 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Wed, Jul 20, 2011 at 09:39:05PM +0800, djkurtz@chromium.org wrote:
> > From: Daniel Kurtz <djkurtz@chromium.org>
> >
>
> Do we know what we want to do with this gesture? Because if not I'd
> rather not merge it for now, until there are real users.

And do what instead?
Report 5 fingers with BTN_TOOL_QUADTAP?

> Thanks.
>
> --
> Dmitry
