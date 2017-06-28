From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2 12/12] ASoC: Fix use-after-free at card
	unregistration
Date: Thu, 29 Jun 2017 00:03:58 +0200
Message-ID: <87o9t7u5v5.fsf@belgarion.home>
References: <1497857229-12049-1-git-send-email-robert.jarzmik@free.fr>
 <1497857229-12049-13-git-send-email-robert.jarzmik@free.fr>
 <s5hefug72iu.wl-tiwai@suse.de> <87injstckf.fsf@belgarion.home>
 <20170628195349.pqeb3dceddxar75s@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20170628195349.pqeb3dceddxar75s@sirena.org.uk> (Mark Brown's
 message of "Wed, 28 Jun 2017 20:53:49 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com, stable@vger.kernel.org, linux-input@vger.kernel.org, Daniel Mack <daniel@zonque.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:

> On Mon, Jun 19, 2017 at 01:57:20PM +0200, Robert Jarzmik wrote:
>
>> My serie shifted by one, so the very first of the serie is therefore missing,
>> formerly "ALSA: ac97: split out the generic ac97 registers" in
>> https://patchwork.kernel.org/patch/9398143/, and the shift triggered the
>> inclusion of the last patch of my tree, ie. yours :)
>
> Based on the missing first patch I was expecting the series to get
> reposted?
Hi Mark,

The first patch is only moving around a .h file. I was expecting a review before
reposting a v3.

Cheers.

-- 
Robert
