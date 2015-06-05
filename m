From: "James.Chen" <james.chen@emc.com.tw>
Subject: RE: [PATCH] CHROMIUM: elants_i2c: Solved previous issue on 3.10 and 3.14.
Date: Fri, 5 Jun 2015 15:48:02 +0800
Message-ID: <003501d09f63$f48aa510$dd9fef30$@emc.com.tw>
References: <1433315176-12805-1-git-send-email-james.chen@emc.com.tw> <20150605053828.GC29704@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150605053828.GC29704@dtor-ws>
Content-Language: zh-tw
Sender: linux-kernel-owner@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Herman Lin' <herman.lin@emc.com.tw>, 'Scott Liu' <scott.liu@emc.com.tw>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 'Jeff Chuang' <jeff.chuang@emc.com.tw>, 'Agnes Cheng' <agnescheng@google.com>
List-Id: linux-input@vger.kernel.org

Hi Dmitry:

Thank you for your suggestion.
We will base on the top of mainline driver and re-submit the patch.

James

-----Original Message-----
From: linux-input-owner@vger.kernel.org
[mailto:linux-input-owner@vger.kernel.org] On Behalf Of Dmitry Torokhov
Sent: Friday, June 05, 2015 1:38 PM
To: james.chen
Cc: Herman Lin; Scott Liu; linux-kernel@vger.kernel.org;
linux-input@vger.kernel.org; Jeff Chuang; Agnes Cheng
Subject: Re: [PATCH] CHROMIUM: elants_i2c: Solved previous issue on 3.10 and
3.14.

Hi James,

On Wed, Jun 03, 2015 at 03:06:16PM +0800, james.chen wrote:
> From: "james.chen" <james.chen@emc.com.tw>
> 
> This patch refer 3.10 driver code to solve firmware upgrade 
> issue(Change 266813) and enable noise-immunity(Change 243875).
> 
> BUG=chrome-os-partner:39373
> TEST=Test Elan Touch Screen on cyan project without problems.

As I mentioned elsewhere this does not simply address firmware upgrade and
noise immunity issues but rather overlays version that can be found in 3.10
ChromeOS kernel on top of mainline driver, removing a lot of cleanups and
fixes that went into preparing the driver for mainline inclusion.

Thanks.

--
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" in
the body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
