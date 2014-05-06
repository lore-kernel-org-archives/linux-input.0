From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH 0/4] Input: atmel_mxt_ts - make it work on Tegra
Date: Tue, 6 May 2014 15:16:40 -0700
Message-ID: <CANLzEkv8To0gWWYBF3JjRDqt+1xGUhQiYJJUwovVhBDEMW569Q@mail.gmail.com>
References: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:58738 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbaEFWQk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 May 2014 18:16:40 -0400
Received: by mail-vc0-f173.google.com with SMTP id il7so172288vcb.32
        for <linux-input@vger.kernel.org>; Tue, 06 May 2014 15:16:40 -0700 (PDT)
In-Reply-To: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>

Hi Stephen,

On Tue, May 6, 2014 at 3:13 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> This series contains the minimum number of patches required to make the
> Atmel MXT touchpad work on NVIDIA Tegra, which requires the device to be
> instantiated from device tree rather than from a C board file.
>
> These patches are based on patches in the ChromeOS kernel. However, I took
> a different approach to the devicetree-doesn't-provide-platform-data issue.
> Rather than amending all users of platform data to work with or without it,
> as the patches in the ChromeOS kernel do, I implemented a single function
> mxt_parse_dt() to create a platform data structure from DT. This isolates
> the changes required to a single function, rather than spreading them all
> over the driver.

Please coordinate with Nick Dyer, who has a long patch series that's
been approved but not yet merged into the input tree. The few patches
you've picked from the Chrome OS kernel overlap with his patch series.

-- 
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
