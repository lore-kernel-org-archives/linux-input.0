From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 01/17] ARM: sunxi: Register cpufreq-dt for sun[45678]i
Date: Wed, 7 Jan 2015 15:31:49 +0530
Message-ID: <CAKohpon33KzojZL+u8hjAJdhXzY-c_V96xCgd+Pa7+cP=p6Tbg@mail.gmail.com>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
	<1420511727-8242-2-git-send-email-wens@csie.org>
	<20150106155532.GR7853@lukather>
	<CAGb2v64Qv1Nhy2w--4T7ujw9NC17QhJdmrn0VyDtTajv+tu+NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35660 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbbAGKBu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Jan 2015 05:01:50 -0500
Received: by mail-ob0-f174.google.com with SMTP id uz6so2363825obc.5
        for <linux-input@vger.kernel.org>; Wed, 07 Jan 2015 02:01:49 -0800 (PST)
In-Reply-To: <CAGb2v64Qv1Nhy2w--4T7ujw9NC17QhJdmrn0VyDtTajv+tu+NQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 7 January 2015 at 14:37, Chen-Yu Tsai <wens@csie.org> wrote:
> I believe you are referring to the work done by Viresh Kumar (CCed),
> specifically the 2 series "[RFC V1 0/8] CPUFreq: create platform-dev
> for DT based cpufreq drivers" and "[RFC] OPP: Redefine bindings to
> overcome shortcomings". So far the new code has not appeared in
> linux-next. If it does, I will happily use it.

Yes. You still have to create these platform devices for cpufreq-dt.
