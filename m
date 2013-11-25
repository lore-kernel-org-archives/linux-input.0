From: Denis Carikli <denis@eukrea.com>
Subject: Re: [PATCH] Input: tsc2007 - convert to use devres-managed resources
Date: Mon, 25 Nov 2013 09:40:39 +0100
Message-ID: <52930D07.2060805@eukrea.com>
References: <20131121051438.GA6180@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131121051438.GA6180@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Bill Pemberton <wfp5p@virginia.edu>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 11/21/2013 06:14 AM, Dmitry Torokhov wrote:
> This simplifies error handling path and allows us get rid of
> tsc2007_remove().
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I tested on top of the "tsc2007 misc fixes" and the "tsc2007 - remove 
unused poll_delay from platform data" patches.

Tested-by: Denis Carikli <denis@eukrea.com>

Denis.
