From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V4 0/3] Input: goodix - add axis swapping and axis
 inversion support
Date: Thu, 17 Dec 2015 17:15:01 -0800
Message-ID: <20151218011501.GC16016@dtor-ws>
References: <1448112622-2062-1-git-send-email-merker@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448112622-2062-1-git-send-email-merker@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Karsten Merker <merker@debian.org>
Cc: Bastien Nocera <hadess@hadess.net>, Irina Tirdea <irina.tirdea@intel.com>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
List-Id: linux-input@vger.kernel.org

On Sat, Nov 21, 2015 at 02:30:19PM +0100, Karsten Merker wrote:
> Hello,
> 
> this is v4 of my "Input: goodix - add axis swapping and axis inversion
> support" patchset.
> 
> The goodix touchscreen driver has gained device-tree support in kernel
> 4.1, but doesn't currently support the touchscreen-swapped-x-y,
> touchscreen-inverted-x and touchscreen-inverted-y properties.
> On systems which combine a portrait-mode display with a landscape-mode
> touchscreen, such as e.g. the MSI Primo 81 tablet, support for these
> features is necessary to have the touchscreen and the display use the
> same coordinate system.
> 
> With support for axis inversion, the "rotated_screen" flag in the
> driver can also be removed, as "rotated_screen" is just a special case
> of x/y axis inversion.
> 
> This patchset sits on top of the "[PATCH v11 0/8] Goodix touchscreen
> enhancements" series by Irina Tirdea:
> https://www.spinics.net/lists/linux-input/msg42146.html
> 
> The axis swapping has successfully been tested on an MSI Primo 81
> tablet and on a Wexler TAB7200 tablet; the x/y inversion resp. 
> the rotated_screen functionality has successfully been tested on
> a WinBook TW100.

Folded 3 into 1 and applied everything, see my goodix branch.

Thanks.

-- 
Dmitry
