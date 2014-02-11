From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 RESEND] ims-pcu: Add commands supported by the new
 version of the FW
Date: Tue, 11 Feb 2014 08:29:43 -0800
Message-ID: <20140211162943.GB12106@core.coreip.homeip.net>
References: <1392132520-2497-1-git-send-email-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392132520-2497-1-git-send-email-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Andrey,

On Tue, Feb 11, 2014 at 07:28:40AM -0800, Andrey Smirnov wrote:
> New version of the PCU firmware supports two new commands:
>   - IMS_PCU_CMD_OFN_SET_CONFIG which allows to write data to the
>   registers of one finger navigation(OFN) chip present on the device
>   - IMS_PCU_CMD_OFN_GET_CONFIG which allows to read data form the
>   registers of said chip.
> 
> This commit adds two helper functions to use those commands and sysfs
> attributes to use them. It also exposes some OFN configuration
> parameters via sysfs.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I have it queued for the next merge window.

Thanks.

-- 
Dmitry
