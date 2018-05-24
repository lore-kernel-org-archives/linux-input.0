From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [GIT PULL] IB chrome-platform/input for atmel_mxt_ts &
 chromeos_laptop for device properties
Date: Thu, 24 May 2018 16:18:40 -0700
Message-ID: <20180524231840.GD177107@dtor-ws>
References: <20180523195645.GA92470@decatoncale.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180523195645.GA92470@decatoncale.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benson Leung <bleung@google.com>
Cc: bleung@chromium.org, linux-input@vger.kernel.org, dtor@chromium.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, May 23, 2018 at 12:56:45PM -0700, Benson Leung wrote:
> Hi Dmitry,
> 
> The following changes since commit 96a938aa214e965d5b4a2f10443b29cad14289b9:
> 
>   Input: atmel_mxt_ts - remove platform data support (2018-04-09 22:55:16 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git ib-chrome-platform-atmel-mxt-ts-device-properties
> 
> for you to fetch changes up to 5020cd29d8bfcb3f3add43ea7d58b07011ab96d8:
> 
>   platform/chrome: chromeos_laptop - supply properties for ACPI devices (2018-05-23 12:48:31 -0700)
> 
> ----------------------------------------------------------------
> Dmitry Torokhov (1):
>       platform/chrome: chromeos_laptop - supply properties for ACPI devices
> 
>  drivers/platform/chrome/chromeos_laptop.c | 307 +++++++++++++++++++++++++++---
>  1 file changed, 278 insertions(+), 29 deletions(-)

Thanks Benson!

-- 
Dmitry
