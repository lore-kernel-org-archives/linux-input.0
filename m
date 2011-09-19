From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 5/8] ASoC: twl6040: Fix the number of
 channels for vibra
Date: Mon, 19 Sep 2011 23:17:23 +0100
Message-ID: <20110919221723.GG23179@opensource.wolfsonmicro.com>
References: <1316091561-30899-1-git-send-email-peter.ujfalusi@ti.com>
 <1316091561-30899-6-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1316091561-30899-6-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Samuel Ortiz <samuel.ortiz@intel.com>, Dmitry Torokhov <dtor@mail.ru>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: linux-input@vger.kernel.org

On Thu, Sep 15, 2011 at 03:59:18PM +0300, Peter Ujfalusi wrote:
> Only mono audio can be used for vibra (DL4 channel).

Applied, thanks.
