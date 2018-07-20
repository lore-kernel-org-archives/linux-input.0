From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/3] Input: edt-ft5x06 - Add support for regulator
Date: Fri, 20 Jul 2018 07:43:55 -0600
Message-ID: <20180720134355.GA24750@rob-hp-laptop>
References: <20180718182719.29663-1-mylene.josserand@bootlin.com>
 <20180718182719.29663-2-mylene.josserand@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180718182719.29663-2-mylene.josserand@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: dmitry.torokhov@gmail.com, mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@bootlin.com
List-Id: linux-input@vger.kernel.org

On Wed, Jul 18, 2018 at 08:27:17PM +0200, Mylène Josserand wrote:
> Add the support of regulator to use it as VCC source.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> ---
>  .../bindings/input/touchscreen/edt-ft5x06.txt      |  1 +

Please add acks when posting new versions.

>  drivers/input/touchscreen/edt-ft5x06.c             | 29 ++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
