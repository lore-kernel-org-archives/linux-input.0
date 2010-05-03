From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: ATMEL camera interface
Date: Mon, 03 May 2010 17:39:36 +0200
Message-ID: <4BDEEE38.9070801@atmel.com>
References: <4BD9AA8A.7030306@atmel.com> <Pine.LNX.4.64.1004291824200.4666@axis700.grange> <4BDED3A8.4090606@atmel.com> <Pine.LNX.4.64.1005031556570.4231@axis700.grange> <4BDEDB06.9090909@atmel.com> <Pine.LNX.4.64.1005031622040.4231@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.atmel.fr ([81.80.104.162]:34396 "EHLO atmel-es2.atmel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932720Ab0ECPjm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 May 2010 11:39:42 -0400
In-Reply-To: <Pine.LNX.4.64.1005031622040.4231@axis700.grange>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, linux-input@vger.kernel.org

Well sorry to bother you again but I am looking at the mx1_camera.c=20
file, and I wonder where are implemented the queue and dqueue functions=
?

The atmel IP is using linked list for the buffers, and previously I was=
=20
managing it in the queue and dqueue functions.
I am not sure where I should take care of it now?


Regards,
Sedji

Le 5/3/2010 4:26 PM, Guennadi Liakhovetski a =E9crit :
> On Mon, 3 May 2010, Sedji Gaouaou wrote:
>
>> Well I need contiguous memory, so I guess I will have a look at mx1_=
camera.c?
>> Is there another example?
>>
>> What do you mean by videobuf implementation? As I said I just need a
>> contiguous memory.
>
> I mean, whether you're gping to use videobuf-dma-contig.c or
> videobuf-dma-sg.c, respectively, whether you'll be calling
> videobuf_queue_dma_contig_init() or videobuf_queue_sg_init() in your
> driver.
>
> Regards
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
>


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
