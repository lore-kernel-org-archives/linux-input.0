From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] Input: wm831x-on: Improve a size determination in
 wm831x_on_probe()
Date: Thu, 25 Jan 2018 09:49:32 +0000
Message-ID: <20180125094932.5ue4aueosfehkzsn@localhost.localdomain>
References: <e307cfde-58e2-3f4d-ecd7-5c80ace0bb5b@users.sourceforge.net>
 <43f052c7-c98d-7ca2-08ca-e5428b5ad575@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <43f052c7-c98d-7ca2-08ca-e5428b5ad575@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-input@vger.kernel.org, patches@opensource.cirrus.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 24, 2018 at 10:22:35PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 24 Jan 2018 21:58:42 +0100
> 
> Replace the specification of a data structure by a pointer dereference
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
