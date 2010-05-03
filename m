From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: ATMEL camera interface
Date: Mon, 3 May 2010 18:40:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005031836140.4231@axis700.grange>
References: <4BD9AA8A.7030306@atmel.com> <Pine.LNX.4.64.1004291824200.4666@axis700.grange>
 <4BDED3A8.4090606@atmel.com> <Pine.LNX.4.64.1005031556570.4231@axis700.grange>
 <4BDEDB06.9090909@atmel.com> <Pine.LNX.4.64.1005031622040.4231@axis700.grange>
 <4BDEEE38.9070801@atmel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <4BDEEE38.9070801@atmel.com>
Sender: linux-media-owner@vger.kernel.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 3 May 2010, Sedji Gaouaou wrote:

> Well sorry to bother you again but I am looking at the mx1_camera.c f=
ile, and
> I wonder where are implemented the queue and dqueue functions?
>=20
> The atmel IP is using linked list for the buffers, and previously I w=
as
> managing it in the queue and dqueue functions.
> I am not sure where I should take care of it now?

qbuf and dqbuf are implemented by soc-camera in soc_camera_qbuf() and=20
soc_camera_dqbuf() respectively, drivers only implement methods from=20
struct videobuf_queue_ops, e.g., a .buf_queue method, which for mx1_cam=
era=20
is implemented by mx1_videobuf_queue().

Thanks
Guennadi

>=20
>=20
> Regards,
> Sedji
>=20
> Le 5/3/2010 4:26 PM, Guennadi Liakhovetski a =E9crit :
> > On Mon, 3 May 2010, Sedji Gaouaou wrote:
> >=20
> > > Well I need contiguous memory, so I guess I will have a look at
> > > mx1_camera.c?
> > > Is there another example?
> > >=20
> > > What do you mean by videobuf implementation? As I said I just nee=
d a
> > > contiguous memory.
> >=20
> > I mean, whether you're gping to use videobuf-dma-contig.c or
> > videobuf-dma-sg.c, respectively, whether you'll be calling
> > videobuf_queue_dma_contig_init() or videobuf_queue_sg_init() in you=
r
> > driver.
> >=20
> > Regards
> > Guennadi
> > ---
> > Guennadi Liakhovetski, Ph.D.
> > Freelance Open-Source Software Developer
> > http://www.open-technology.de/
> >=20
>=20
>=20

---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/
