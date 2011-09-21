From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 8/8] ASoC: twl6040: Support for vibra
	output paths
Date: Wed, 21 Sep 2011 16:12:42 +0300
Message-ID: <3085965.EdoSnJ6VqI@barack>
References: <1316091561-30899-1-git-send-email-peter.ujfalusi@ti.com>
	<1316091561-30899-9-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1316091561-30899-9-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <samuel.ortiz@intel.com>
Cc: alsa-devel@alsa-project.org, Dmitry Torokhov <dtor@mail.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: linux-input@vger.kernel.org

Hi Mark,

On Thursday 15 September 2011 15:59:21 Peter Ujfalusi wrote:
> twl6040 have two vibra output drivers.
> They can be operated with audio stream coming through
> the PDM interface (fifth channel).
> The vibra outputs can be controlled via the input/FF
> driver as well.
> Selection between the two mode is implemented within
> the codec driver, the input/FF driver can only operate if
> the routing is set to "Input FF".
> Changing from "Input FF" to "Audio PDM" mode is protected
> as well: The switchin can only be done, if there is no
> running effect from the input/FF.

Can you take a look at this patch?

Thank you,
P=E9ter
