From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] Add possibility to control the
	GPIO_STATUS shift
Date: Fri, 17 Jul 2009 12:22:15 +0100
Message-ID: <20090717112215.GB19871@rakim.wolfsonmicro.main>
References: <200907171001.16889.marek.vasut@gmail.com>
	<20090717103253.GF3439@rakim.wolfsonmicro.main>
	<200907171312.15548.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <200907171312.15548.marek.vasut@gmail.com>
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

On Fri, Jul 17, 2009 at 01:12:15PM +0200, Marek Vasut wrote:

> The CPU used is pxa270c5 and pxa270c0. The chip is WM1613 (seems to report 
> itself as WM9712 though). Maybe it's correction in that chip? There's no 
> datasheet available to it though.

Ah, that is crucial information which you hadn't previously provided.
If you rework the patch as adding support for WM1613 with the interface
being one that enables a WM1613 mode rather than tweaking the GPIO
offset that'd be OK.
