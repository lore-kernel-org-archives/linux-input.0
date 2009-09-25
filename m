From: "Paulraj, Sandeep" <s-paulraj-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/3] Input: DaVinci Key Scan Driver
Date: Fri, 25 Sep 2009 09:39:13 -0500
Message-ID: <0554BEF07D437848AF01B9C9B5F0BC5D92C8EBC0@dlee01.ent.ti.com>
References: <1253811202-21407-1-git-send-email-miguel.aguilar@ridgerun.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DDAB3271@dbde02.ent.ti.com>
	<4ABCD1E8.5000200@ridgerun.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DDAB36C3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DDAB36C3-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
Cc: "santiago.nunez-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org" <santiago.nunez-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>, "todd.fischer-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org" <todd.fischer-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "clark.becker-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org" <clark.becker-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org


>=20
> On Fri, Sep 25, 2009 at 19:51:28, Miguel Aguilar wrote:
> > Nori, Sekhar wrote:
> > > On Thu, Sep 24, 2009 at 22:23:22, miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org wrote:
> > >> From: Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
> > >>
> > >> Adds the driver for enabling key scan support for DaVinci platforms.
> > >>
> > >> DM365 is the only platform that uses this driver at the moment.
> > >>
> > >> Signed-off-by: Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
> > >> ---
> > >
> > > [...]
> > >
> > >> +
> > >> +/* Initializing the kp Module */
> > >> +static void davinci_ks_initialize(struct davinci_ks *davinci_ks)
> > >> +{
> > >> +     u32 strobe =3D davinci_ks->pdata->strobe;
> > >> +     u32 interval =3D davinci_ks->pdata->interval;
> > >> +
> > >> +     /* Enable all interrupts */
> > >> +     davinci_ks_write(davinci_ks, DAVINCI_KEYSCAN_INT_ALL,
> DAVINCI_KEYSCAN_INTENA);
> > >> +
> > >> +     /* Clear interrupts if any */
> > >> +     davinci_ks_write(davinci_ks, DAVINCI_KEYSCAN_INT_ALL,
> DAVINCI_KEYSCAN_INTCLR);
> > >> +
> > >> +     /* Setup the scan period =3D strobe + interval */
> > >> +     davinci_ks_write(davinci_ks, strobe,
> DAVINCI_KEYSCAN_STRBWIDTH);
> > >> +     davinci_ks_write(davinci_ks, interval,
> DAVINCI_KEYSCAN_INTERVAL);
> > >> +     davinci_ks_write(davinci_ks, 0x01, DAVINCI_KEYSCAN_CONTTIME);
> > >> +
> > >> +     /* Enable Keyscan module and enable */
> > >> +     davinci_ks_write(davinci_ks, DAVINCI_KEYSCAN_AUTODET |
> DAVINCI_KEYSCAN_KEYEN,
> > >> +                     DAVINCI_KEYSCAN_KEYCTRL);
> > >
> > > We seem to be hardcoded to the 4x4 matrix type here.
> > > Some DM365 boards could use 5x3 matrix.
> > >
> > > Thanks,
> > > Sekhar
> > >
> >
> > [MA] I will add a platform option for matrix type to choose 4x4 or 5x3
> matrix.
> > What do think about this?
> >
>=20
> Sounds good. I am not sure if any other piece of code
> needs to change though.
The strobe and interval have to change.  Afcourse that change comes into th=
e picture only when the mode is changed from 4x4 to 5x3.
I can see that there are options given for this in board specific code.
>=20
> Thanks,
> Sekhar

Thanks,
Sandeep
