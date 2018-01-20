From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 2/2] Input: zforce_ts: Delete an unnecessary return statement in zforce_input_close()
Date: Sat, 20 Jan 2018 21:27:13 +0100
Message-ID: <7942584.ySXY2G0O1B@phil>
References: <e36553b1-3221-7944-59bd-6bb9358c488f@users.sourceforge.net> <7d14b5af-bc11-305c-6a90-18e8a3b3196c@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <7d14b5af-bc11-305c-6a90-18e8a3b3196c@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Am Samstag, 20. Januar 2018, 21:20:38 CET schrieb SF Markus Elfring:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 20 Jan 2018 20:43:06 +0100
> 
> The script "checkpatch.pl" pointed information out like the following.
> 
> WARNING: void function return statements are not generally useful
> 
> Thus remove such a statement in the affected function.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

if it helps
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
