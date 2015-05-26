From: "Cooper Jr., Franklin" <fcooper@ti.com>
Subject: RE: AM335x touchscreen issues
Date: Tue, 26 May 2015 21:34:10 +0000
Message-ID: <8F29D6B095ED194EA1980491A5E029710C89C4E0@DFLE08.ent.ti.com>
References: <20150526181157.GA8009@deathray>
 <20150526183713.GU26599@saruman.tx.rr.com> <20150526205310.GA2104@deathray>
 <8F29D6B095ED194EA1980491A5E029710C89C445@DFLE08.ent.ti.com>
 <20150526212851.GA12224@deathray>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57916 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751714AbbEZVeW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 May 2015 17:34:22 -0400
In-Reply-To: <20150526212851.GA12224@deathray>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: "Balbi, Felipe" <balbi@ti.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "R, Vignesh" <vigneshr@ti.com>, "Griffis, Brad" <bgriffis@ti.com>, "jic23@kernel.org" <jic23@kernel.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "GWilson@sakuraus.com" <GWilson@sakuraus.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf Of Michael
> Welling
> Sent: Tuesday, May 26, 2015 4:29 PM
> To: Cooper Jr., Franklin
> Cc: Balbi, Felipe; dmitry.torokhov@gmail.com; R, Vignesh; Griffis, Brad;
> jic23@kernel.org; wsa@the-dreams.de; linux-input@vger.kernel.org;
> GWilson@sakuraus.com; linux-iio@vger.kernel.org
> Subject: Re: AM335x touchscreen issues
> 
> On Tue, May 26, 2015 at 09:15:53PM +0000, Cooper Jr., Franklin wrote:
> > Michael,
> >
> > Can you send me the output of ts_test_raw after you done a 5 or so touch
> down and touch up events? In the output let me know at which point in the
> log that the issue you observed has occurred. Please try to avoid moving your
> finger since I want to see the full output of that program but I'm not
> interested any unnecessary pen down events.
> >
> 
> Oddly the repeated pen up and down events do not occur when running
> ts_print_raw:
> root@som3517-som200:~# ts_print_raw
> 1418169393.147827:   1648   2075    206
> 1418169393.229976:   1725   1983    240
> 1418169393.312154:   1731   1980    240
> 1418169393.394333:   1706   2043    239
> 1418169393.476523:   1703   2028    241
> 1418169393.558708:   1714   2041    240
> 1418169393.640888:   1704   2041    240
> 1418169393.721556:      0      0      0
> 1418169395.283096:   2889   2512    192
> 1418169395.365236:   2947   2486    210
> 1418169395.447413:   2949   2470    211
> 1418169395.529606:   2943   2497    211
> 1418169395.611759:   2922   2506    211
> 1418169395.693935:   2866   2474    213
> 1418169395.776135:   2858   2481    214
> 1418169395.858305:   2861   2451    213
> 1418169395.938972:      0      0      0
> 1418169397.482867:   1083   1981    236
> 1418169397.565026:   1157   1832    254
> 1418169397.647217:   1161   1856    256
> 1418169397.729412:   1158   1883    255
> 1418169397.811583:   1159   1841    255
> 1418169397.893760:   1159   1864    256
> 1418169397.975947:   1158   1893    256
> 1418169398.056605:      0      0      0
> 1418169399.690290:   2299   2372    178
> 1418169399.772432:   2388   2160    221
> 1418169399.854611:   2391   2190    223
> 1418169399.936802:   2379   2207    223
> 1418169400.018966:   2389   2184    223
> 1418169400.101146:   2383   2208    224
> 1418169400.183338:   2381   2203    223
> 1418169400.264012:      0      0      0
> 1418169402.073266:   1230   2381    212
> 1418169402.155413:   1301   2097    247
> 1418169402.237590:   1313   2077    248
> 1418169402.319772:   1307   2126    248
> 1418169402.401948:   1304   2096    248
> 1418169402.484127:   4078   2155     58
> 1418169402.564801:      0      0      0
> 
> Here is what the output of ts_test looks like without even touching the
> screen:
> root@som3517-som200:~# ts_test
> 1418169549.722957:    816     17     58
> 1418169549.803604:    816     17      0
> 1418169549.817757:    816     25     58
> 1418169549.898411:    816     25      0
> 1418169549.912828:    816     41     59
> 1418169549.993463:    816     41      0
> 1418169550.007771:    816     28     58
> 1418169550.088404:    816     28      0
> 1418169550.102828:    816     33     58
> 1418169550.183486:    816     33      0
> 1418169550.197767:    816     42     59
> 1418169550.278401:    816     42      0
> 1418169550.292970:    816     23     58
> 1418169550.373604:    816     23      0
> 1418169550.387773:    816     28     58
> 1418169550.468404:    816     28      0
> 1418169550.482955:    816     32     59
> 1418169550.563600:    816     32      0
> 1418169550.577773:    816     25     58
> 1418169550.658406:    816     25      0
> 1418169550.672827:    816     35     59
> 1418169550.753464:    816     35      0
> 1418169550.767761:    816     42     59
> 1418169550.848407:    816     42      0
> 1418169550.862826:    816     41     59
> 1418169550.943462:    816     41      0
> 1418169550.958013:    816     37     59
> 1418169551.038655:    816     37      0
> 1418169551.052824:    816     41     59
> 1418169551.133475:    816     41      0
> 1418169551.147774:    816     28     58
> 1418169551.228406:    816     28      0
[Franklin] So your saying the above ts_test is being ran and you never touched the screen? Looking at the mailing list post you sent earlier it seems like the goal is for the ADC to be used at the same time. Is that the case when you ran both ts_test and ts_print_raw?


> .
> .
> 
> > I recently encountered several touchscreen problems that I am working on
> submitting to mainline. Below are the variety of issues I discovered and fixed
> but its currently based on 3.14 kernel.
> >
> > 1. The x and y location right before a penup event is usually incorrect.
> Visibly the causes the cursor to jump right before a touchup. So I
> implemented a way to ignore that incorrect event.
> > 2. I discovered that for some reason a series of touch up events are sent
> back to back. So I added something to ignore consecutive pen up events.
> > 3. Sometimes a pen down event is reported with a pressure of 0. I noticed
> applications like ts_lib looked at the pressure and thought a pressure of 0
> means a finger was lifted. So I added a patch that ignored 0 pressure pen
> down events. This prevented premature touchups.
> > 4. I added debouncing. Essentially the driver didn't report any touch events
> for a user specified number of ms after a pen up occured. It was noticed
> especially during touchscreen calibration that after a person lifted their finger
> after touching the screen a combination of pen up and pen down events
> were incorrectly detected.
> >
> > Most likely a combination of 2-4 is your problem. I think the udelay acted
> like an unintentional debounce which is probably why it wasn't discovered
> sooner.
> > > >
> > > > --
> > > > balbi
> > >
> >
