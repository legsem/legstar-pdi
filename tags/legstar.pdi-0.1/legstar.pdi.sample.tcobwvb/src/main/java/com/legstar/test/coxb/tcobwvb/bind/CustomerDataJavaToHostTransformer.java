package com.legstar.test.coxb.tcobwvb.bind;

import com.legstar.coxb.CobolContext;
import com.legstar.coxb.ICobolComplexBinding;
import com.legstar.coxb.transform.AbstractJavaToHostTransformer;
import com.legstar.coxb.CobolBindingException;

/**
 * Transforms a CustomerData data object to mainframe data.
 * <p/>
 * This is a typical use of this class:
 * <pre>
 *  CustomerDataJavaToHostTransformer transformer = new CustomerDataJavaToHostTransformer();
 *  byte[] hostByteArray = transformer.transform(javaValue);
 * </pre>
 *
 */
public class CustomerDataJavaToHostTransformer extends AbstractJavaToHostTransformer {

    
    /**
     * Create a Java to Host transformer using default COBOL parameters.
     */
    public CustomerDataJavaToHostTransformer() {
        super();
    }
    
    /**
     * Create a Java to Host transformer using a specific COBOL parameters set.
     * @param cobolContext the COBOL parameters set.
     */
    public CustomerDataJavaToHostTransformer(final CobolContext cobolContext) {
        super(cobolContext);
    }

    /**
     * Create a Java to Host transformer using a specific host character set while
     * other COBOL parameters are set by default.
     * @param hostCharset the host character set
     */
    public CustomerDataJavaToHostTransformer(final String hostCharset) {
        super(hostCharset);
    }
    
    /**
     * Binding is statically produced by {@link com.legstar.coxb.gen.CoxbBindingGenerator}.
     * @return the binding corresponding to the host structure type.
     * @throws CobolBindingException if binding cannot be returned
     */
    public ICobolComplexBinding getBinding() throws CobolBindingException {
        return new CustomerDataBinding();
    }
    
}