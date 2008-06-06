From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack reporting v2
Date: Fri, 6 Jun 2008 15:23:01 +0100
Message-ID: <20080606142300.GE24872@sirena.org.uk>
References: <1212095345928-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20080603104048.GA17007@rakim.wolfsonmicro.main>
	<20080603105920.ZZRA012@mailhub.coreip.homeip.net>
	<20080603233813.GA30512@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20080603233813.GA30512@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, mjg59@srcf.ucam.org, alsa-devel@alsa-project.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jun 04, 2008 at 12:38:14AM +0100, Mark Brown wrote:

> There is an additional motivation for using an input device for jacks -
> it is common to support a button implemented by shorting the microphone
> connection as well as simply detecting the presence of something in the
> jack.

Dimitry, do you have any further thoughts on this?  Due to jacks being
able to function as buttons as well as switches I do prefer the use of
input devices for jack reporting but if you still disagree I'll redo the
patch since I don't feel *that* strongly.
