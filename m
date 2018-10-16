From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: uinput - fix Spectre v1 vulnerability
Date: Tue, 16 Oct 2018 10:21:07 -0700
Message-ID: <20181016172107.GA230131@dtor-ws>
References: <20181016111313.GA28307@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181016111313.GA28307@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Gustavo,

On Tue, Oct 16, 2018 at 01:13:13PM +0200, Gustavo A. R. Silva wrote:
> setup.code can be indirectly controlled by user-space, hence leading to
> a potential exploitation of the Spectre variant 1 vulnerability.
> 
> This issue was detected with the help of Smatch:
> 
> drivers/input/misc/uinput.c:512 uinput_abs_setup() warn: potential
> spectre issue 'dev->absinfo' [w] (local cap)
> 
> Fix this by sanitizing setup.code before using it to index dev->absinfo.

So we are saying that attacker, by repeatedly calling ioctl(...,
UI_ABS_SETUP, ...) will be able to poison branch predictor and discover
another program or kernel secrets? But uinput is a privileged interface
open to root only, as it allows injecting arbitrary keystrokes into the
kernel. And since only root can use uinput, meh?

Thanks.

-- 
Dmitry
