From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3 05/12] Input: wm97xx: split out
	touchscreen registering
Date: Mon, 3 Jul 2017 09:58:17 +0100
Message-ID: <20170703085817.fajdhhgamngxfnwp@localhost.localdomain>
References: <20170630194408.24978-1-robert.jarzmik@free.fr>
 <20170630194408.24978-6-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20170630194408.24978-6-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Takashi Iwai <tiwai@suse.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jun 30, 2017 at 09:44:01PM +0200, Robert Jarzmik wrote:
> wm97xx-core does several things in it initialization :
>  - touchscreen input device setup
>  - battery device creation
> 
> As the wm97xx is actually a multi-function device handling an audio
> codec, a touchscreen, a gpio block and an ADC, reshape the probing to
> isolate what is truly input/touchscreen specific from the remaining
> part.
> 
> This is only code shuffling, there is no functional change.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
