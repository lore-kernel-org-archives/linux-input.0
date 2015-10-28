From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] alps: Only the Dell Latitude D420/430/620/630 have
 separate stick button bits
Date: Tue, 27 Oct 2015 22:50:36 -0700
Message-ID: <20151028055036.GC16963@localhost>
References: <1445415378-4820-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445415378-4820-1-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, stable@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Oct 21, 2015 at 10:16:18AM +0200, Hans de Goede wrote:
> commit 92bac83dd79e ("Input: alps - non interleaved V2 dualpoint has
> separate stick button bits") assumes that all alps v2 non-interleaved
> dual point setups have the separate stick button bits.
> 
> Later we limited this to Dell laptops only because of reports that this
> broke things on non Dell laptops. Now it turns out that this breaks things
> on the Dell Latitude D600 too. So it seems that only the Dell Latitude
> D420/430/620/630, which all share the same touchpad / stick combo,
> have these separate bits.
> 
> This patch limits the checking of the separate bits to only these models
> fixing regressions with other models.
> 
> Reported-and-tested-by: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: stable@vger.kernel.org
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thank you.

-- 
Dmitry
