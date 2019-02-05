From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/2] Input: add Apple SPI keyboard and trackpad
 driver.
Date: Tue, 5 Feb 2019 13:21:10 +0300
Message-ID: <20190205102110.GG2581@kadam>
References: <20190204081947.25152-3-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <kbuild-bounces@lists.01.org>
Content-Disposition: inline
In-Reply-To: <20190204081947.25152-3-ronald@innovation.ch>
List-Unsubscribe: <https://lists.01.org/mailman/options/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/kbuild/>
List-Post: <mailto:kbuild@lists.01.org>
List-Help: <mailto:kbuild-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=subscribe>
Errors-To: kbuild-bounces@lists.01.org
Sender: "kbuild" <kbuild-bounces@lists.01.org>
To: kbuild@01.org, Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, kbuild-all@01.org, linux-input@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Hi Ronald,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Ronald-Tschal-r/drm-bridge=
-sil_sii8620-depend-on-INPUT-instead-of-selecting-it/20190205-003319
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next

smatch warnings:
drivers/input/keyboard/applespi.c:1551 applespi_get_saved_bl_level() warn: =
returning -1 instead of -ENOMEM is sloppy

# https://github.com/0day-ci/linux/commit/cfa9f37054a5b21113aa8b00c45527514=
5114f8e
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout cfa9f37054a5b21113aa8b00c455275145114f8e
vim +1551 drivers/input/keyboard/applespi.c

cfa9f3705 Ronald Tschal=E4r 2019-02-04  1541  =

cfa9f3705 Ronald Tschal=E4r 2019-02-04  1542  static int applespi_get_saved=
_bl_level(void)
cfa9f3705 Ronald Tschal=E4r 2019-02-04  1543  {
cfa9f3705 Ronald Tschal=E4r 2019-02-04  1544  	struct efivar_entry *efivar_=
entry;
cfa9f3705 Ronald Tschal=E4r 2019-02-04  1545  	u16 efi_data =3D 0;
cfa9f3705 Ronald Tschal=E4r 2019-02-04  1546  	unsigned long efi_data_len;
cfa9f3705 Ronald Tschal=E4r 2019-02-04  1547  	int sts;
cfa9f3705 Ronald Tschal=E4r 2019-02-04  1548  =

cfa9f3705 Ronald Tschal=E4r 2019-02-04  1549  	efivar_entry =3D kmalloc(siz=
eof(*efivar_entry), GFP_KERNEL);
cfa9f3705 Ronald Tschal=E4r 2019-02-04  1550  	if (!efivar_entry)
cfa9f3705 Ronald Tschal=E4r 2019-02-04 @1551  		return -1;
cfa9f3705 Ronald Tschal=E4r 2019-02-04  1552  =

cfa9f3705 Ronald Tschal=E4r 2019-02-04  1553  	memcpy(efivar_entry->var.Var=
iableName, EFI_BL_LEVEL_NAME,
cfa9f3705 Ronald Tschal=E4r 2019-02-04  1554  	       sizeof(EFI_BL_LEVEL_N=
AME));
cfa9f3705 Ronald Tschal=E4r 2019-02-04  1555  	efivar_entry->var.VendorGuid=
 =3D EFI_BL_LEVEL_GUID;
cfa9f3705 Ronald Tschal=E4r 2019-02-04  1556  	efi_data_len =3D sizeof(efi_=
data);
cfa9f3705 Ronald Tschal=E4r 2019-02-04  1557  =

cfa9f3705 Ronald Tschal=E4r 2019-02-04  1558  	sts =3D efivar_entry_get(efi=
var_entry, NULL, &efi_data_len, &efi_data);
cfa9f3705 Ronald Tschal=E4r 2019-02-04  1559  	if (sts && sts !=3D -ENOENT)
cfa9f3705 Ronald Tschal=E4r 2019-02-04  1560  		pr_warn("Error getting back=
light level from EFI vars: %d\n",
cfa9f3705 Ronald Tschal=E4r 2019-02-04  1561  			sts);
cfa9f3705 Ronald Tschal=E4r 2019-02-04  1562  =

cfa9f3705 Ronald Tschal=E4r 2019-02-04  1563  	kfree(efivar_entry);
cfa9f3705 Ronald Tschal=E4r 2019-02-04  1564  =

cfa9f3705 Ronald Tschal=E4r 2019-02-04  1565  	return efi_data;
cfa9f3705 Ronald Tschal=E4r 2019-02-04  1566  }
cfa9f3705 Ronald Tschal=E4r 2019-02-04  1567  =
