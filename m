From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/5] Fix Elan I2C touchpads in latest generation from
 Lenovo
Date: Fri, 12 Oct 2018 11:53:42 -0700
Message-ID: <20181012185342.GA35430@dtor-ws>
References: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: KT Liao <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Oct 12, 2018 at 04:24:08PM +0200, Benjamin Tissoires wrote:
> Since v4.18, we unconditionally switch the I2C capable touchpads over I2C.
> In the model I had (a pre-prod t480s I guess), the touchpad was behaving
> fine.
> However, it occurs that later production models don't expose the clickpad
> information from I2C. The Windows driver gets all the information from PS/2
> so we should do the same.
> 
> The situation is even worse for the P52. Once of the query parameter function
> fails, which means the touchpad doesn't even probe. This effectively kills
> the touchpad, which is less than ideal.
> 
> Dmitry, I am not sure if we should take those for stable in v4.18+.
> I'd like to, but given the series is 5 patches, I don't know if this
> will be acceptable.
> We could revert in stable df077237cf55928f5 but that would mean
> distributions will have to revert the revert if they want to provide
> the I2C behavior.
> 
> So, regarding stable: your call :)

Heh ;) I think we have to fix it at least in 4.19 stable train. How
about we merge it normally into 4.20, and let it cook there for a while.
If there is no issues, then we can send it to 4.19 stable manually. How
does this sound?

Thanks.

-- 
Dmitry
