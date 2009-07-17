From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] Add possibility to control the
	GPIO_STATUS shift
Date: Fri, 17 Jul 2009 12:43:12 +0100
Message-ID: <20090717114312.GA20492@rakim.wolfsonmicro.main>
References: <200907171001.16889.marek.vasut@gmail.com>
	<200907171312.15548.marek.vasut@gmail.com>
	<20090717112215.GB19871@rakim.wolfsonmicro.main>
	<200907171326.08512.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <200907171326.08512.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jul 17, 2009 at 01:26:08PM +0200, Marek Vasut wrote:

> But how the heck am I supposed to detect it's wm1613 if it reports itself as 
> wm9712 ? Apparently, on treo680 it reports itself as wm9713 (even better).

The same way your current patch does it.  I'm just saying you should
change the way the configuration is passed in so that it is clear that
this is only useful for WM1613.
