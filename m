From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: misc: Add TI drv2665 haptics driver
Date: Fri, 8 May 2015 17:08:02 -0700
Message-ID: <20150509000802.GA29994@dtor-ws>
References: <1431114365-23911-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35491 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbbEIAIH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 May 2015 20:08:07 -0400
Received: by ieczm2 with SMTP id zm2so75238053iec.2
        for <linux-input@vger.kernel.org>; Fri, 08 May 2015 17:08:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1431114365-23911-1-git-send-email-dmurphy@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-input@vger.kernel.org

Hi Dan,

On Fri, May 08, 2015 at 02:46:05PM -0500, Dan Murphy wrote:
> +
> +/* 8kHz Sine wave to stream to the FIFO */
> +struct drv2665_waveform {
> +	u8 data;
> +} sine_wave_form[] = {
I changed this into

static const u8 drv2665_sine_wave_form[] = {
...
};

and applied (together with the other 2 patches).

Thanks.

-- 
Dmitry
