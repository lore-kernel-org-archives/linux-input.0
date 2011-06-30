From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: kernel panic in spi_complete() on spitz (PXA270)
Date: Thu, 30 Jun 2011 18:25:51 +0300
Message-ID: <4E0C957F.8080807@compulab.co.il>
References: <1308845380.4533.54.camel@oct.suse.cz>	
	<201106301352.21684.marek.vasut@gmail.com>
	<1309445118.4406.47.camel@oct.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1309445118.4406.47.camel@oct.suse.cz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stanislav Brabec <utx@penguin.cz>
Cc: broonie@opensource.wolfsonmicro.com, vapier@gentoo.org, eric.y.miao@gmail.com, khilman@deeprootsystems.com, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>, pavel@ucw.cz, linux-input@vger.kernel.org, spi-devel-general@lists.sourceforge.net, akpm@linux-foundation.org, zaurus-devel@lists.linuxtogo.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On 06/30/11 17:45, Stanislav Brabec wrote:

> Marek Vasut wrote:
>> On Thursday, June 23, 2011 06:09:40 PM Stanislav Brabec wrote:
>>> Hallo.
>>>
>>> These Oops and kernel panic were observed on a Zaurus (spitz) machine
>>> (ARMv5, PXA270).
>> Looks similar to "Re: [PATCH v2] Input: Make ADS7846 independent on regulator"
> I don't see any trace in that thread. But yes, I was testing your patch
> from this thread. Without it, ADS7846 does not work on spitz (ADS7846
> does not have any dedicated regulator there). I want to
> add .needs_regulator bool to ads7846.c and send the patch again to the
> list.

Please, don't...
I thought we've finished discussing the regulator issue...

Instead of patching the driver and the platform data and the board file,
you should do _either_ of the following:
1) add regulator definition for ads7846 into the board file
2) enable the CONFIG_REGULATOR_DUMMY in your kernel configuration
3) use regulator_use_dummy_regulator() call in the board file.

Using either of the above, you will not need the patch for ads7846, only for the board file.


-- 
Regards,
Igor.
