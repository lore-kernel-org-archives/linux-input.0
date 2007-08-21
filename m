From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH] Console keyboard events and accessibility
Date: Tue, 21 Aug 2007 22:49:51 +0200
Message-ID: <20070821204951.GC3658@interface.famille.thibault.fr>
References: <20070821005718.GD3658@interface.famille.thibault.fr> <Pine.LNX.4.64.0708210732270.5333@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708210732270.5333@fbirervta.pbzchgretzou.qr>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jan Engelhardt <jengelh@computergmbh.de>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, dtor@mail.ru
List-Id: linux-input@vger.kernel.org

Hi,

Jan Engelhardt, le Tue 21 Aug 2007 22:42:24 +0200, a =E9crit :
> >- keycodes: even before translation into keysym.
>=20
> They can use the raw xlation for that.

For userland, yes.  This is for kernel modules.

Samuel
