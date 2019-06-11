From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 02/10] mfd / platform: cros_ec: Move
 cros-ec core driver out from MFD
Date: Tue, 11 Jun 2019 10:09:00 -0700
Message-ID: <20190611170900.GB143729@dtor-ws>
References: <20190604152019.16100-1-enric.balletbo@collabora.com>
 <20190604152019.16100-3-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20190604152019.16100-3-enric.balletbo@collabora.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: gwendal@chromium.org, Banajit Goswami <bgoswami@codeaurora.org>, Vignesh R <vigneshr@ti.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org, Mark Brown <broonie@kernel.org>, Juergen Fitschen <jfi@ssv-embedded.de>, alsa-devel@alsa-project.org, Stefan Agner <stefan@agner.ch>, Sebastian Reichel <sre@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Guenter Roeck <groeck@chromium.org>, kernel@collabora.com, dtor@chromium.org, Lars-Peter Clausen <lars@metafoo.de>, Jean Delvare <jdelvare@suse.de>, Jacky Bai <ping.bai@nxp.com>, linux-rtc@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sean
List-Id: linux-input@vger.kernel.org

On Tue, Jun 04, 2019 at 05:20:11PM +0200, Enric Balletbo i Serra wrote:
> Now, the ChromeOS EC core driver has nothing related to an MFD device, so
> move that driver from the MFD subsystem to the platform/chrome subsystem.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input

Thanks.

-- 
Dmitry
