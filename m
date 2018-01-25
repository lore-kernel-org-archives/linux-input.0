From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] Input: wm831x-on: Delete an error message for a
 failed memory allocation in wm831x_on_probe()
Date: Thu, 25 Jan 2018 09:49:10 +0000
Message-ID: <20180125094910.t4w75kk4ygyw5x76@localhost.localdomain>
References: <e307cfde-58e2-3f4d-ecd7-5c80ace0bb5b@users.sourceforge.net>
 <d393999d-0c39-c9ea-3a0c-eb534e61b665@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d393999d-0c39-c9ea-3a0c-eb534e61b665@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-input@vger.kernel.org, patches@opensource.cirrus.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 24, 2018 at 10:21:39PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 24 Jan 2018 21:55:49 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
