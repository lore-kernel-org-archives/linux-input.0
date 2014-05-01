From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH 01/15] ASoC: CS42L51 and WM8962 codecs
 depend on INPUT
Date: Thu, 1 May 2014 12:26:18 +0000
Message-ID: <C1FD6191-8850-4BB1-ABA1-BE6D02F9CD84@cirrus.com>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-2-git-send-email-kaixu.xia@linaro.org>
 <alpine.DEB.2.02.1404292124270.31465@heelrod>
 <20140501013103.GK3245@sirena.org.uk>
 <13D36045-EE68-418B-983B-2704C52391E3@cirrus.com>
 <08914164-8CE6-4170-BC21-9E2840FFA05E@cirrus.com>,
 <20140501032756.GM3245@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20140501032756.GM3245@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, "arnd@arndb.de" <arnd@arndb.de>, Sangbeom Kim <sbkim73@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Timur Tabi <timur@tabi.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Xia Kaixu <kaixu.xia@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-input@vger.kernel.org



> On Apr 30, 2014, at 22:28, "Mark Brown" <broonie@kernel.org> wrote:
> =

>> On Thu, May 01, 2014 at 02:16:27AM +0000, Austin, Brian wrote:
>> =

>> Apparently not.
>> I would like to come up with a better solution than making INPUT a requi=
rement. I just need some time.
>> In the meantime I suppose it=92s OK to apply it?
> =

> Yeah.  Realistically it's probably not going to ever be a practical
> problem - the number of systems with audio but no input is likely to be
> very close to zero.

Yeah, I'm just gonna go ahead and remove the #if's from the drivers then si=
nce it's required =
