From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [0/2] Jack reporting
Date: Mon, 14 Jul 2008 16:11:00 +0100
Message-ID: <20080714151058.GF25448@sirena.org.uk>
References: <20080703095026.GA652@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20080703095026.GA652@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Dmitry Torokhov <dtor@insightbb.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jul 03, 2008 at 10:50:27AM +0100, Mark Brown wrote:
> This is a repost of the the jack reporting API I posted recently.  There
> are no chances since the last submission - as discussed in that thread
> the existing users and the need to support buttons implemented in jacks
> pushes me towards use of an input device to represent jacks.

Takashi, do you have any comments on these patches?
