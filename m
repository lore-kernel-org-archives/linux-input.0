From: <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 13/17] twl4030: mfd_cell is now implicitly
 available to drivers
Date: Sat, 12 Feb 2011 15:15:02 +0000
Message-ID: <CF32F28EDF8D20468EEDCBE4975DA0274A4309@008-AM1MPN1-027.mgdnok.nokia.com>
References: <20110211181538.3230cb99@queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20110211181538.3230cb99@queued.net>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: dilinger@queued.net, sameo@linux.intel.com
Cc: alsa-devel@alsa-project.org, dmitry.torokhov@gmail.com, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, lrg@slimlogic.co.uk
List-Id: linux-input@vger.kernel.org

> ________________________________________
> From: ext Andres Salomon [dilinger@queued.net]
> Sent: Saturday, February 12, 2011 04:15
> To: Samuel Ortiz
> Cc: linux-kernel@vger.kernel.org; Mark Brown; Dmitry Torokhov; Ujfalusi Peter (Nokia-MS/Tampere); Liam Girdwood; Jaroslav Kysela; Takashi Iwai; linux-input@vger.kernel.org; alsa-devel@alsa-project.org
> Subject: [PATCH 13/17] twl4030: mfd_cell is now implicitly available to drivers
> 
> The cell's platform_data is now accessed with a helper function;
> change clients to use that, and remove the now-unused data_size.
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>
> ---

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
