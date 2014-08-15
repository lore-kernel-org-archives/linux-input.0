From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 2/2] Input: atmel_mxt_ts - Add keycodes array example
Date: Fri, 15 Aug 2014 14:01:56 +0200
Message-ID: <53EDF6B4.7080804@collabora.co.uk>
References: <1407372486-25881-1-git-send-email-javier.martinez@collabora.co.uk> <1407372486-25881-2-git-send-email-javier.martinez@collabora.co.uk> <53E37329.4020002@itdev.co.uk> <53E4E41D.4070703@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <53E4E41D.4070703@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stephen Warren <swarren@nvidia.com>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello Nick,

On 08/08/2014 04:52 PM, Javier Martinez Canillas wrote:
On 08/07/2014 02:38 PM, Nick Dyer wrote:
>> >>
>> 
>> I'm afraid you have misunderstood the impact of this change to the way that
>> the GPIOs coming in to the touch controller are mapped to key codes. Look
> 
> Unfortunately there are no boards in mainline using this "linux,gpio-keymap"
> property so I tried to figure out what the expected values were by reading the
> driver. So is more than possible that I got them wrong.
> 
> By passing all these keycodes the touchpad worked as expected for me and the
> driver did the same than the Chrome OS driver that has these keycodes hardcoded
> when is_tp is true.
> 
>> at the protocol guide for T19.
>> 
> 
> I don't have access to proper documentation and I wouldn't expect people to have
> access to non-public docs in order to use a Device Tree binding.
> 
> That's why I wanted to document an example, so using this property could be
> easier for others and they shouldn't have to look at the driver in order to
> figure it out (and getting it wrong as you said :) )
> 
> So it would be great if you could provide an example on how this is supposed to
> be used.
> 

Any comments on this? I would really appreciate if you can expand on how
this DT property is supposed to be used so I can re-spin the atmel support
patch for Peach boards.

Thanks a lot and best regards,
Javier
