From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/5] Input: Drop unnecessary calls to input_set_drvdata
Date: Sun, 22 Jan 2017 17:30:09 -0800
Message-ID: <20170123013009.GA29135@dtor-ws>
References: <1485132505-14562-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485132505-14562-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Jan 22, 2017 at 04:48:19PM -0800, Guenter Roeck wrote:
> If there is not call to dev_get_drvdata() or input_get_drvdata(),
> the call to input_set_drvdata() is unnecessary and can be dropped.
> 
> The series was build tested on kerneltests.org and by the 0day build system.
> 
> The patch series is based on v4.10-rc4, with input/next (sha 2de8b4110c82)
> merged on top. For convenience, the series is available at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git input-base
> 
> ----------------------------------------------------------------
> Guenter Roeck (5):
>       Input: keyboard - drop unnecessary calls to input_set_drvdata
>       Input: joystick/maplecontrol - drop unnecessary call to input_set_drvdata
>       Input: mouse - drop unnecessary calls to input_set_drvdata
>       Input: misc/dm355evm_keys - drop unnecessary call to input_set_drvdata
>       Input: touchscreen - drop unnecessary calls to input_set_drvdata

Applied the lot, thank you.

-- 
Dmitry
