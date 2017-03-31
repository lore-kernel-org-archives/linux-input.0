From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 3/4] Input: synaptics-rmi4 - cleanup SMbus mapping
 handling
Date: Fri, 31 Mar 2017 11:21:34 +0200
Message-ID: <20170331092134.GJ22683@mail.corp.redhat.com>
References: <20170325060050.39867-1-dmitry.torokhov@gmail.com>
 <20170325060050.39867-3-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753586AbdCaJVq (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 31 Mar 2017 05:21:46 -0400
Content-Disposition: inline
In-Reply-To: <20170325060050.39867-3-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Dyer <nick@shmanahar.org>

On Mar 24 2017 or thereabouts, Dmitry Torokhov wrote:
> There is no reason to copy structures field-by-filed when we can copy
> eements at once.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

OK, and now I realize why 2/4 was needed. The current code was just
plain wrong because rmiaddr was tagged as __le16. This fixes the storing
issue.

This one (and the previous then):
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/input/rmi4/rmi_smbus.c | 43 ++++++++++++++++++------------------------
>  1 file changed, 18 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
> index c8bf49686460..724643bf31a6 100644
> --- a/drivers/input/rmi4/rmi_smbus.c
> +++ b/drivers/input/rmi4/rmi_smbus.c
> @@ -83,62 +83,55 @@ static int rmi_smb_get_command_code(struct rmi_transport_dev *xport,
>  {
>  	struct rmi_smb_xport *rmi_smb =
>  		container_of(xport, struct rmi_smb_xport, xport);
> +	struct mapping_table_entry new_map;
>  	int i;
> -	int retval;
> -	struct mapping_table_entry mapping_data[1];
> +	int retval = 0;
>  
>  	mutex_lock(&rmi_smb->mappingtable_mutex);
> +
>  	for (i = 0; i < RMI_SMB2_MAP_SIZE; i++) {
>  		struct mapping_table_entry *entry = &rmi_smb->mapping_table[i];
>  		if (le16_to_cpu(entry->rmiaddr) == rmiaddr) {
>  			if (isread) {
> -				if (entry->readcount == bytecount) {
> -					*commandcode = i;
> -					retval = 0;
> +				if (entry->readcount == bytecount)
>  					goto exit;
> -				}
>  			} else {
>  				if (entry->flags & RMI_SMB2_MAP_FLAGS_WE) {
> -					*commandcode = i;
> -					retval = 0;
>  					goto exit;
>  				}
>  			}
>  		}
>  	}
> +
>  	i = rmi_smb->table_index;
>  	rmi_smb->table_index = (i + 1) % RMI_SMB2_MAP_SIZE;
>  
>  	/* constructs mapping table data entry. 4 bytes each entry */
> -	memset(mapping_data, 0, sizeof(mapping_data));
> -
> -	mapping_data[0].rmiaddr = cpu_to_le16(rmiaddr);
> -	mapping_data[0].readcount = bytecount;
> -	mapping_data[0].flags = !isread ? RMI_SMB2_MAP_FLAGS_WE : 0;
> -
> -	retval = smb_block_write(xport, i + 0x80, mapping_data,
> -				 sizeof(mapping_data));
> +	memset(&new_map, 0, sizeof(new_map));
> +	new_map.rmiaddr = cpu_to_le16(rmiaddr);
> +	new_map.readcount = bytecount;
> +	new_map.flags = !isread ? RMI_SMB2_MAP_FLAGS_WE : 0;
>  
> +	retval = smb_block_write(xport, i + 0x80, &new_map, sizeof(new_map));
>  	if (retval < 0) {
>  		/*
>  		 * if not written to device mapping table
>  		 * clear the driver mapping table records
>  		 */
> -		rmi_smb->mapping_table[i].rmiaddr = 0x0000;
> -		rmi_smb->mapping_table[i].readcount = 0;
> -		rmi_smb->mapping_table[i].flags = 0;
> -		goto exit;
> +		memset(&new_map, 0, sizeof(new_map));
>  	}
> +
>  	/* save to the driver level mapping table */
> -	rmi_smb->mapping_table[i].rmiaddr = rmiaddr;
> -	rmi_smb->mapping_table[i].readcount = bytecount;
> -	rmi_smb->mapping_table[i].flags = !isread ? RMI_SMB2_MAP_FLAGS_WE : 0;
> -	*commandcode = i;
> +	rmi_smb->mapping_table[i] = new_map;
>  
>  exit:
>  	mutex_unlock(&rmi_smb->mappingtable_mutex);
>  
> -	return retval;
> +	if (retval < 0)
> +		return retval;
> +
> +	*commandcode = i;
> +	return 0;
>  }
>  
>  static int rmi_smb_write_block(struct rmi_transport_dev *xport, u16 rmiaddr,
> -- 
> 2.12.1.578.ge9c3154ca4-goog
> 
