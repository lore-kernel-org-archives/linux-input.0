From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 13/29] twl4030: mfd_cell is now implicitly
 available to drivers (v2)
Date: Fri, 18 Feb 2011 08:44:14 +0200
Message-ID: <4D5E153E.308@nokia.com>
References: <1297998456-7615-1-git-send-email-dilinger@queued.net>
	<1297998456-7615-14-git-send-email-dilinger@queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1297998456-7615-14-git-send-email-dilinger@queued.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Andres Salomon <dilinger@queued.net>
Cc: alsa-devel@alsa-project.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-input@vger.kernel.org

On 02/18/11 05:07, ext Andres Salomon wrote:
> The cell's platform_data is now accessed with a helper function;
> change clients to use that, and remove the now-unused data_size.
> 
> v2: add some missing mfd/core.h includes.
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>
> ---
>  drivers/input/misc/twl4030-vibra.c |    3 ++-
>  drivers/mfd/twl4030-codec.c        |    2 --
>  sound/soc/codecs/twl4030.c         |    6 ++++--
>  3 files changed, 6 insertions(+), 5 deletions(-)

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
