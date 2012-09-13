From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH] input: fix input_open_file() accessing out-of-bound buffers
Date: Thu, 13 Sep 2012 18:18:17 +0200
Message-ID: <CANq1E4Rs7ue8E7prx8KQ=UxLrhRdYA9YV7URGHLiV3yGAmrePA@mail.gmail.com>
References: <1347553050-25480-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:47155 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab2IMQST (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 12:18:19 -0400
Received: by wgbfm10 with SMTP id fm10so640650wgb.1
        for <linux-input@vger.kernel.org>; Thu, 13 Sep 2012 09:18:18 -0700 (PDT)
In-Reply-To: <1347553050-25480-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@googlemail.com>

Hi Dmitry

On Thu, Sep 13, 2012 at 6:17 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> The "input_table" array is very small and we cannot be sure that the file
> the user opens has a minor-ID below 256 (8 << 5). Hence, simply check that
> the minor isn't out-of-bounds. If it is, return -ENODEV.
>
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> Cc: <stable@kernel.org>

This should be "Cc: <stable@vger.kernel.org>". Sorry for the typo.

Thanks
David
