From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: PROBLEM: "BUG:" when resuming from suspend-to-ram
Date: Thu, 1 Mar 2007 10:01:02 -0500
Message-ID: <d120d5000703010701y44ba3cfcxf58e1897fe47a4d6@mail.gmail.com>
References: <1172601905.5428.28.camel@localhost.localdomain>
	 <1172622441.4587.14.camel@localhost.localdomain>
	 <200702281345.15098.rjw@sisk.pl>
	 <200703010036.28166.dtor@insightbb.com>
	 <1172760952.21416.110.camel@miraculinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1172760952.21416.110.camel@miraculinux>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: =?ISO-8859-1?Q?Kristian_Gr=F8nfeldt_S=F8rensen?= <kriller@vkr.dk>
Cc: linux-input@atrey.karlin.mff.cuni.cz, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 3/1/07, Kristian Gr=F8nfeldt S=F8rensen <kriller@vkr.dk> wrote:
> On Thu, 2007-03-01 at 00:36 -0500, Dmitry Torokhov wrote:
> >
> > Please try the patch below.
>
> Hmmm. Is the diff against 2.6.20? All hunks except one fails when i try
> it. If I pass "-F 3" to patch, then one more hunk succeeds. Am I doing
> something wrong?
>

Hm, technically speaking it is against 2.6.21-rc2 but I think exceppt
for tsdev part it should apply to 2.6.20...

--=20
Dmitry
