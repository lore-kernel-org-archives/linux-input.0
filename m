From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH 01/15] ASoC: CS42L51 and WM8962 codecs
 depend on INPUT
Date: Thu, 1 May 2014 01:54:00 +0000
Message-ID: <13D36045-EE68-418B-983B-2704C52391E3@cirrus.com>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-2-git-send-email-kaixu.xia@linaro.org>
 <alpine.DEB.2.02.1404292124270.31465@heelrod>,
 <20140501013103.GK3245@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20140501013103.GK3245@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "arnd@arndb.de" <arnd@arndb.de>, Sangbeom Kim <sbkim73@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Timur Tabi <timur@tabi.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Ben Dooks <ben-linux@fluff.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Xia Kaixu <kaixu.xia@linaro.org>
List-Id: linux-input@vger.kernel.org



> On Apr 30, 2014, at 20:31, "Mark Brown" <broonie@kernel.org> wrote:
> 
>> On Tue, Apr 29, 2014 at 09:31:30PM -0500, Brian Austin wrote:
>> 
>> I assume you mean the CS42L52 instead of the L51. INPUT is used for a BEEP
>> Generator but when I disable CONFIG_INPUT I do not get an error. Is there
>> any information available on what the error is?
> 
> I suspect it's ASoC built in and INPUT build as a module.
Ok, I'll try that next.
Doesn't IS_ENABLED cover that?
