From: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Subject: Re: AM335x touchscreen issues
Date: Tue, 26 May 2015 16:50:49 -0500
Message-ID: <20150526215049.GC12224@deathray>
References: <20150526181157.GA8009@deathray>
 <20150526183713.GU26599@saruman.tx.rr.com>
 <20150526205310.GA2104@deathray>
 <8F29D6B095ED194EA1980491A5E029710C89C445@DFLE08.ent.ti.com>
 <20150526212851.GA12224@deathray>
 <8F29D6B095ED194EA1980491A5E029710C89C4E0@DFLE08.ent.ti.com>
 <912A29987EAE174BA6CF187D7CDFA9CE270A8C43@DLEE08.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <912A29987EAE174BA6CF187D7CDFA9CE270A8C43-YmePFLaaepqIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Griffis, Brad" <bgriffis-l0cyMroinI0@public.gmane.org>
Cc: "Cooper Jr., Franklin" <fcooper-l0cyMroinI0@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "R, Vignesh" <vigneshr-l0cyMroinI0@public.gmane.org>, "jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "GWilson-+8BKOH/0X5NWk0Htik3J/w@public.gmane.org" <GWilson-+8BKOH/0X5NWk0Htik3J/w@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, May 26, 2015 at 09:36:57PM +0000, Griffis, Brad wrote:
> 
> > -----Original Message-----
> > From: Cooper Jr., Franklin
> > > -----Original Message-----
> > > From: Michael Welling [mailto:mwelling79-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] On Behalf Of
> > > Michael Welling
> > > Sent: Tuesday, May 26, 2015 4:29 PM
> > > To: Cooper Jr., Franklin
> > > Cc: Balbi, Felipe; dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; R, Vignesh; Griffis,
> > > Brad; jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org;
> > > linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; GWilson-+8BKOH/0X5NWk0Htik3J/w@public.gmane.org;
> > > linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > Subject: Re: AM335x touchscreen issues
> > >
> > > On Tue, May 26, 2015 at 09:15:53PM +0000, Cooper Jr., Franklin wrote:
> > > > Michael,
> > > >
> > > > Can you send me the output of ts_test_raw after you done a 5 or so
> > > > touch
> > > down and touch up events? In the output let me know at which point in
> > > the log that the issue you observed has occurred. Please try to avoid
> > > moving your finger since I want to see the full output of that program
> > > but I'm not interested any unnecessary pen down events.
> > > >
> > >
> > > Oddly the repeated pen up and down events do not occur when running
> > > ts_print_raw:
> > > root@som3517-som200:~# ts_print_raw
> > > 1418169393.147827:   1648   2075    206
> > > 1418169393.229976:   1725   1983    240
> > > 1418169393.312154:   1731   1980    240
> > > 1418169393.394333:   1706   2043    239
> > > 1418169393.476523:   1703   2028    241
> > > 1418169393.558708:   1714   2041    240
> > > 1418169393.640888:   1704   2041    240
> > > 1418169393.721556:      0      0      0
> > > 1418169395.283096:   2889   2512    192
> > > 1418169395.365236:   2947   2486    210
> > > 1418169395.447413:   2949   2470    211
> > > 1418169395.529606:   2943   2497    211
> > > 1418169395.611759:   2922   2506    211
> > > 1418169395.693935:   2866   2474    213
> > > 1418169395.776135:   2858   2481    214
> > > 1418169395.858305:   2861   2451    213
> > > 1418169395.938972:      0      0      0
> > > 1418169397.482867:   1083   1981    236
> > > 1418169397.565026:   1157   1832    254
> > > 1418169397.647217:   1161   1856    256
> > > 1418169397.729412:   1158   1883    255
> > > 1418169397.811583:   1159   1841    255
> > > 1418169397.893760:   1159   1864    256
> > > 1418169397.975947:   1158   1893    256
> > > 1418169398.056605:      0      0      0
> > > 1418169399.690290:   2299   2372    178
> > > 1418169399.772432:   2388   2160    221
> > > 1418169399.854611:   2391   2190    223
> > > 1418169399.936802:   2379   2207    223
> > > 1418169400.018966:   2389   2184    223
> > > 1418169400.101146:   2383   2208    224
> > > 1418169400.183338:   2381   2203    223
> > > 1418169400.264012:      0      0      0
> > > 1418169402.073266:   1230   2381    212
> > > 1418169402.155413:   1301   2097    247
> > > 1418169402.237590:   1313   2077    248
> > > 1418169402.319772:   1307   2126    248
> > > 1418169402.401948:   1304   2096    248
> > > 1418169402.484127:   4078   2155     58
> > > 1418169402.564801:      0      0      0
> > >
> > > Here is what the output of ts_test looks like without even touching
> > > the
> > > screen:
> > > root@som3517-som200:~# ts_test
> > > 1418169549.722957:    816     17     58
> > > 1418169549.803604:    816     17      0
> > > 1418169549.817757:    816     25     58
> > > 1418169549.898411:    816     25      0
> > > 1418169549.912828:    816     41     59
> > > 1418169549.993463:    816     41      0
> > > 1418169550.007771:    816     28     58
> > > 1418169550.088404:    816     28      0
> > > 1418169550.102828:    816     33     58
> > > 1418169550.183486:    816     33      0
> > > 1418169550.197767:    816     42     59
> > > 1418169550.278401:    816     42      0
> > > 1418169550.292970:    816     23     58
> > > 1418169550.373604:    816     23      0
> > > 1418169550.387773:    816     28     58
> > > 1418169550.468404:    816     28      0
> > > 1418169550.482955:    816     32     59
> > > 1418169550.563600:    816     32      0
> > > 1418169550.577773:    816     25     58
> > > 1418169550.658406:    816     25      0
> > > 1418169550.672827:    816     35     59
> > > 1418169550.753464:    816     35      0
> > > 1418169550.767761:    816     42     59
> > > 1418169550.848407:    816     42      0
> > > 1418169550.862826:    816     41     59
> > > 1418169550.943462:    816     41      0
> > > 1418169550.958013:    816     37     59
> > > 1418169551.038655:    816     37      0
> > > 1418169551.052824:    816     41     59
> > > 1418169551.133475:    816     41      0
> > > 1418169551.147774:    816     28     58
> > > 1418169551.228406:    816     28      0
> > [Franklin] So your saying the above ts_test is being ran and you never
> > touched the screen? Looking at the mailing list post you sent earlier it seems
> > like the goal is for the ADC to be used at the same time. Is that the case when
> > you ran both ts_test and ts_print_raw?
> 
> I was also wondering if this relates to raw ADC samples being captured.  The TSCADC should not be capturing anything at all if the screen is not touched.  You need the pen-down event to initiate the capture sequence.  I'm curious what the state of the pins is during this occurrence, i.e. are we actually seeing some kind of event on the lines?  I suspect that something is misconfigured somewhere, perhaps resulting in a change of state in the pins that registers as a pen-down.

Then why would reverting a commit make the problem go away?

It seems to have something to do with the characteristic of the touchscreen
as this does not happen on my 7" display.

Looking at the datasheet these pin are dedicated analogs and cannot be
MUX'd otherwise.

http://www.ti.com/lit/ds/symlink/am3354.pdf 
page 20
